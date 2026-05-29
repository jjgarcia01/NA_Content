namespace: My_stuff
flow:
  name: write_me
  inputs:
    - test_lab:
        prompt:
          type: text
    - labRecord:
        prompt:
          type: text
  workflow:
    - create_lab:
        do:
          Integrations.EveNG.Operations.create_lab:
            - test_lab: '${test_lab}'
        publish:
          - labPath
        navigate:
          - SUCCESS: create_node
    - create_node:
        do:
          Integrations.EveNG.Operations.create_node:
            - labPath: '${labPath}'
            - labRecord: '${labRecord}'
        navigate:
          - SUCCESS: add_to_nnmi
    - add_to_nnmi:
        do:
          My_stuff.subflows.add_to_nnmi:
            - labRecord: '${labRecord}'
            - passwd: "${get_sp('NNM_admin_passwd')}"
        navigate:
          - FAILURE: on_failure
          - SUCCESS: start_lab
    - start_lab:
        do:
          Integrations.EveNG.Operations.start_lab:
            - labPath: '${labPath}'
        navigate:
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      create_lab:
        x: 80
        'y': 160
      create_node:
        x: 240
        'y': 160
      add_to_nnmi:
        x: 400
        'y': 160
      start_lab:
        x: 600
        'y': 160
        navigate:
          29fec668-dd11-fa11-3ee2-97d9cf4c5389:
            targetId: 4053c68c-480e-f1f8-ca2b-f9980018ee57
            port: SUCCESS
    results:
      SUCCESS:
        4053c68c-480e-f1f8-ca2b-f9980018ee57:
          x: 800
          'y': 160
