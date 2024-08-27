phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands:
            - sudo apt install -y ruby-full
            - cd /home/ubuntu
            - wget https://aws-codedeploy-${REGION}.s3.${REGION}.amazonaws.com/latest/install
            - chmod +x ./install
            - ./install auto
            - systemctl status codedeploy-agent
        name: ${NAME}
        onFailure: "Abort"
schemaVersion: 1.0