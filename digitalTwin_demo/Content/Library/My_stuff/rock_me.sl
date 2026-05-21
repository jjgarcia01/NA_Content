namespace: My_stuff
flow:
  name: rock_me
  inputs:
    - test_lab:
        prompt:
          type: text
    - recordList:
        prompt:
          type: text
  workflow:
    - create_lab:
        do:
          Integrations.EveNG.Operations.create_lab:
            - username: "${get_sp('eve_admin_user')}"
            - password: "${get_sp('eveng_network_ip')}"
            - eveng_network_ip: "${get_sp('eveng_network_ip')}"
            - test_lab: '${test_lab}'
        publish:
          - labPath
        navigate:
          - SUCCESS: createNode
    - createNode:
        do:
          Integrations.EveNG.Operations.createNode:
            - recordList: '${recordList}'
            - labPath: '${labPath}'
            - eveng_network_ip: "${get_sp('eveng_network_ip')}"
            - username: "${get_sp('eve_admin_user')}"
            - password: "${get_sp('eve_admin_password')}"
        navigate:
          - FAILURE: on_failure
          - SUCCESS: NNM_command
    - start_lab:
        do:
          Integrations.EveNG.Operations.start_lab:
            - username: "${get_sp('eve_admin_user')}"
            - password: "${get_sp('eve_admin_password')}"
            - eveng_network_ip: "${get_sp('eveng_network_ip')}"
            - labPath: '${labPath}'
        navigate:
          - SUCCESS: SUCCESS
    - NNM_command:
        do:
          My_stuff.subflows.NNM_command: []
        navigate:
          - FAILURE: on_failure
          - SUCCESS: start_lab
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      create_lab:
        x: 200
        'y': 160
      createNode:
        x: 360
        'y': 160
      start_lab:
        x: 680
        'y': 160
        navigate:
          70e41fcc-3fcc-04c4-5991-0c4d5996e526:
            targetId: 57db5c47-732f-a50e-991e-64e219051c35
            port: SUCCESS
      NNM_command:
        x: 520
        'y': 160
    results:
      SUCCESS:
        57db5c47-732f-a50e-991e-64e219051c35:
          x: 920
          'y': 160
