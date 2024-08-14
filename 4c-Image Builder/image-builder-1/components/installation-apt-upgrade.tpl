phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands:
            - "apt upgrade -y"
        name: upper("${shortname}-apt-upgrade")
        onFailure: "Abort"
schemaVersion: 1.0