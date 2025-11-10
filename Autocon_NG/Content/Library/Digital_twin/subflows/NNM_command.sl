namespace: Digital_twin.subflows
flow:
  name: NNM_command
  inputs:
    - cmd
    - passwd: "${get_sp('NNM_admin_passwd')}"
  workflow:
    - ssh_command:
        do:
          io.cloudslang.base.ssh.ssh_command:
            - host: nnmi.cloudmylab.com
            - command: "${'echo \"'+passwd+'\" | sudo -S '+cmd}"
            - username: "${get_sp('NNM_admin_user')}"
            - password:
                value: "${get_sp('NNM_admin_passwd')}"
                sensitive: true
            - timeout: '5000'
            - use_shell: 'true'
        publish:
          - standard_out
          - standard_err
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - stdOut: '${standard_out}'
    - stdErr: '${standard_err}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      ssh_command:
        x: 200
        'y': 200
        navigate:
          353fe6d7-a68e-76b8-1fbe-c092801a337f:
            targetId: 6c476990-fac2-dae5-ece5-ffb1d413c1c0
            port: SUCCESS
    results:
      SUCCESS:
        6c476990-fac2-dae5-ece5-ffb1d413c1c0:
          x: 440
          'y': 200
