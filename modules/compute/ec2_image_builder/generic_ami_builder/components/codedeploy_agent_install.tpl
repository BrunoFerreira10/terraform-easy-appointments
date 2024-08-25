phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands:
            - sudo apt install ruby-full
            - cd /home/ubuntu
            - wget https://aws-codedeploy-${REGION}.s3.${REGION}.amazonaws.com/latest/install
            - chmod +x ./install
            - sudo -u ubuntu ./install auto > /tmp/codedeploy-agent-install.log
            - systemctl status codedeploy-agent
        name: ${NAME}
        onFailure: "Abort"
schemaVersion: 1.0