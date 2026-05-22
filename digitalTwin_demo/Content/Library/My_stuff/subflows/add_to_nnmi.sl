namespace: My_stuff.subflows
flow:
  name: add_to_nnmi
  inputs:
    - labRecord:
        prompt:
          type: text
    - passwd
  workflow:
    - set_ipAddress:
        do:
          io.cloudslang.base.utils.sleep:
            - seconds: '0'
            - labRecord: '${labRecord}'
        publish:
          - ipAddress: "${cs_regex(labRecord,'^(?:[^,]+,){2}\\s*([^,]+)')}"
        navigate:
          - SUCCESS: ssh_command
          - FAILURE: on_failure
    - ssh_command:
        do:
          io.cloudslang.base.ssh.ssh_command:
            - host: "${get_sp('NNM_host')}"
            - command: "${'echo \"'+passwd+'\"| sudo -S /opt/OV/bin/nnmloadseeds.ovpl -n '+ipAddress}"
            - pty: 'true'
            - username: "${get_sp('nnm_username')}"
            - password:
                value: '${passwd}'
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
        x: 240
        'y': 200
        navigate:
          353fe6d7-a68e-76b8-1fbe-c092801a337f:
            targetId: 6c476990-fac2-dae5-ece5-ffb1d413c1c0
            port: SUCCESS
      set_ipAddress:
        x: 80
        'y': 200
    results:
      SUCCESS:
        6c476990-fac2-dae5-ece5-ffb1d413c1c0:
          x: 440
          'y': 200
