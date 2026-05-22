namespace: My_stuff
flow:
  name: create_multi_device_lab
  inputs:
    - filePath:
        prompt:
          type: text
    - labName:
        prompt:
          type: text
  workflow:
    - getCSVfile:
        do:
          io.cloudslang.base.filesystem.read_from_file:
            - file_path: '${filePath}'
        publish:
          - csv: '${read_text}'
        navigate:
          - SUCCESS: create_lab
          - FAILURE: on_failure
    - create_lab:
        do:
          Integrations.EveNG.Operations.create_lab:
            - username: "${get_sp('eve_admin_user')}"
            - password: "${get_sp('eve_admin_password')}"
            - eveng_network_ip: "${get_sp('eveng_network_ip')}"
            - test_lab: '${labName}'
        publish:
          - labPath
        navigate:
          - SUCCESS: iterateList
    - start_lab:
        do:
          Integrations.EveNG.Operations.start_lab:
            - username: "${get_sp('eve_admin_user')}"
            - password: "${get_sp('eve_admin_password')}"
            - eveng_network_ip: "${get_sp('eveng_network_ip')}"
            - labPath: '${labPath}'
        navigate:
          - SUCCESS: SUCCESS
    - iterateList:
        do:
          io.cloudslang.base.lists.list_iterator:
            - list: '${csv}'
            - separator: "\\n"
        publish:
          - labRecord: '${result_string}'
        navigate:
          - HAS_MORE: create_node
          - NO_MORE: start_lab
          - FAILURE: on_failure
    - create_node:
        do:
          Integrations.EveNG.Operations.create_node:
            - username: "${get_sp('eve_admin_user')}"
            - password: "${get_sp('eve_admin_password')}"
            - eveng_network_ip: "${get_sp('eveng_network_ip')}"
            - labPath: '${labPath}'
            - labRecord: '${labRecord}'
        navigate:
          - SUCCESS: add_to_nnm
    - add_to_nnm:
        do:
          My_stuff.subflows.add_to_nnm: []
        navigate:
          - FAILURE: on_failure
          - SUCCESS: iterateList
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      getCSVfile:
        x: 40
        'y': 80
      create_lab:
        x: 200
        'y': 80
      create_node:
        x: 320
        'y': 280
      start_lab:
        x: 520
        'y': 80
        navigate:
          895974e3-7a15-fbf6-1b7f-bc37148a8574:
            targetId: b12939f8-f16b-047b-bef9-1ef9c35ece89
            port: SUCCESS
      iterateList:
        x: 320
        'y': 80
      add_to_nnm:
        x: 480
        'y': 280
    results:
      SUCCESS:
        b12939f8-f16b-047b-bef9-1ef9c35ece89:
          x: 680
          'y': 80
