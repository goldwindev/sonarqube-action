## Usage

The workflow, usually declared in `.github/workflows/sonarqube.yml`, looks like:

```yaml
on: push
name: Main Workflow
jobs:
  sonarQubeTrigger:
    name: SonarQube Trigger
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: SonarQube Scan
      uses: goldwindev/sonarqube-action@v1
      with:
        host: ${{ secrets.SONARQUBE_HOST }}
        login: ${{ secrets.SONARQUBE_TOKEN }}
```

You can change the analysis base directory and/ project key _(allowed characters: letters, numbers, -, \_, . and :, with at least one non-digit.)_ by using the optional input like this:

```yaml
uses: goldwindev/sonarqube-action@v1
with:
  projectBaseDir: "/path/to/my-custom-project"
  projectKey: "my-custom-project"
  projectName: "my-custom-project-name"
  projectVersion: "v0.0.1"
```

## Secrets

- `host` - **_(Required)_** this is the SonarQube server URL.
- `login` - **_(Required)_** the login or authentication token of a SonarQube user with Execute Analysis permission on the project. See [how to generate SonarQube token](https://docs.sonarqube.org/latest/user-guide/user-token/).
- `password` - The password that goes with the `login` username. This should be left blank if an `login` are authentication token.

You can set all variable in the "Secrets" settings page of your repository.

## License

The Dockerfile and associated scripts and documentation in this project are released under the MIT License.

Container images built with this project include third party materials.
