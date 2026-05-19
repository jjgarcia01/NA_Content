namespace: Integrations.EveNG.Operations
flow:
  name: createNode
  inputs:
    - recordList
    - labPath
    - eveng_network_ip
    - username
    - password
  workflow:
    - getDeviceName:
        do:
          io.cloudslang.base.lists.get_by_index:
            - list: '${recordList}'
            - delimiter: ','
            - index: '${0}'
        publish:
          - deviceName: '${return_result}'
        navigate:
          - SUCCESS: getImage
          - FAILURE: on_failure
    - getImage:
        do:
          io.cloudslang.base.lists.get_by_index:
            - list: '${recordList}'
            - delimiter: ','
            - index: '${1}'
        publish:
          - image: '${return_result}'
        navigate:
          - SUCCESS: getIPAddress
          - FAILURE: on_failure
    - getIPAddress:
        do:
          io.cloudslang.base.lists.get_by_index:
            - list: '${recordList}'
            - delimiter: ','
            - index: '${2}'
        publish:
          - ipAddress: '${return_result}'
        navigate:
          - SUCCESS: create_node
          - FAILURE: on_failure
    - create_node:
        do:
          Integrations.EveNG.Operations.create_node:
            - username: '${username}'
            - password: '${password}'
            - eveng_network_ip: '${eveng_network_ip}'
            - labPath: '${labPath}'
            - deviceName: '${deviceName}'
            - image: '${image}'
            - ipAddress: '${ipAddress}'
        navigate:
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      create_node:
        x: 640
        'y': 160
        navigate:
          1b25f282-c59f-b170-24f8-730741c0ae54:
            targetId: e51b8927-8d57-8f4a-b9b7-bdc549d0aae3
            port: SUCCESS
      getDeviceName:
        x: 40
        'y': 160
      getIPAddress:
        x: 440
        'y': 160
      getImage:
        x: 240
        'y': 160
    results:
      SUCCESS:
        e51b8927-8d57-8f4a-b9b7-bdc549d0aae3:
          x: 840
          'y': 160
