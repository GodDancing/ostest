import os

# All credentials and internal references are read from the environment.
# See .env.example for the full list of required variables.
TOKEN = os.environ["GITHUB_TOKEN"]
DB = os.environ["DATABASE_URL"]
OWNER = os.environ.get("PROJECT_EMAIL", "you@your-domain.com")
HOME = os.environ.get("PROJECT_HOME", "./workspace")
KEY = os.environ["API_KEY"]


def main():
    print("hello")
