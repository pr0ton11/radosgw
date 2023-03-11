from bs4 import BeautifulSoup
from argparse import ArgumentParser
import requests

### This script queries the version of an alpine package that is available within the Alpine repositories
### It is used to build CI/CD pipelines baed on released packages within the Alpine repo

### Package DB
PACKAGE_DB_URL = "https://pkgs.alpinelinux.org/package"

### Represents an alpine package
class AlpinePackage:

    # Constructor
    def __init__(self, alpine_version: str, alpine_repo: str, alpine_arch: str, package: str):
        # Assign values to object
        self.alpine_version = alpine_version
        self.alpine_repo = alpine_repo
        self.alpine_arch = alpine_arch
        self.package = package

    # Returns the URL for the corresponding package in the alpine package db
    def build_query_string(self):
        return f"{PACKAGE_DB_URL}/{self.alpine_version}/{self.alpine_repo}/{self.alpine_arch}/{self.package}"

    # Returns the code of the requested website as string
    # Handles errors
    def request(self):
        try:
            res = requests.get(self.build_query_string())
            return res.content
        except requests.exceptions.RequestException as e:
            print(f"ERR: Request failed for: {self.build_query_string()}")
            raise SystemExit(e)
    
    # Parses the package version from the package db source code
    def parse_version(self):
        html_parser = BeautifulSoup(self.request(), "html.parser")
        package_info = html_parser.find("table", { "id" : "package" })
        if package_info == None:
            print(f"ERR: Could not query any package with name {self.package}")
            exit(1)
        tr = package_info.find_all("tr")
        for row in tr:
            # Search for version row
            is_version_row = False
            for header in row.find_all('th'):
                if header.text.strip() == "Version":
                    is_version_row = True
            # Found the version row
            if is_version_row:
                # Find the td elements
                data = row.find_all('td')
                if (len(data) != 1):
                    print(f"ERR: Parsing package table for package: {self.package}; invalid version field length")
                    exit(1)
                return data[0].text.strip()
                    
### Entrypoint
if __name__ == '__main__':
    # Add arguments
    argument_parser = ArgumentParser(prog="AlpinePackageVersion", description="Returns the current version of a package in the Alpine Linux Package DB")
    argument_parser.add_argument("-v", "--version", help="Alpine version to query (defaults to edge)", default="edge")
    argument_parser.add_argument("-r", "--repository", help="Alpine repository (main, community, testing) to query (defaults to main)", default="main")
    argument_parser.add_argument("-a", "--architecture", help="Alpine architecture to query (defaults to x86_64)", default="x86_64")
    argument_parser.add_argument("package", help="Name of the alpine package to query")
    # Parse arguments
    args = argument_parser.parse_args()
    # Create an alpine package object
    package = AlpinePackage(args.version, args.repository, args.architecture, args.package)
    # Query the version of the alpine package
    print(package.parse_version())
    exit(0)
