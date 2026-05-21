namespace: My_stuff
flow:
  name: delete_me
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
    - iterateList:
        do:
          io.cloudslang.base.lists.list_iterator:
            - list: '${csv}'
            - separator: "\\n"
        publish:
          - recordList: '${result_string}'
        navigate:
          - HAS_MORE: createNode
          - NO_MORE: start_lab
          - FAILURE: on_failure
    - Add_to_NNM:
        do:
          My_stuff.subflows.NNM_command:
            - cmd: "${'/opt/OV/bin/nnmloadseeds.ovpl -n '+ipAddress+' -t NAF_topology'}"
        navigate:
          - FAILURE: on_failure
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
          - SUCCESS: Add_to_NNM
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      start_lab:
        x: 520
        'y': 80
        navigate:
          895974e3-7a15-fbf6-1b7f-bc37148a8574:
            targetId: b12939f8-f16b-047b-bef9-1ef9c35ece89
            port: SUCCESS
      create_lab:
        x: 200
        'y': 80
      getCSVfile:
        x: 40
        'y': 80
      iterateList:
        x: 360
        'y': 80
      Add_to_NNM:
        x: 520
        'y': 280
      createNode:
        x: 360
        'y': 280
    results:
      SUCCESS:
        b12939f8-f16b-047b-bef9-1ef9c35ece89:
          x: 680
          'y': 80
