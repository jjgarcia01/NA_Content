namespace: Digital_twin.actions
flow:
  name: Create_lab_NG
  inputs:
    - test_lab:
        prompt:
          type: text
    - deviceNames:
        prompt:
          type: text
    - images:
        prompt:
          type: text
    - ipAddresses:
        prompt:
          type: text
  workflow:
    - createLab:
        do:
          Digital_twin.subflows.create_lab_py:
            - test_lab: '${test_lab}'
        publish:
          - labPath
        navigate:
          - SUCCESS: getListLength
    - ForLoop:
        do:
          io.cloudslang.base.utils.counter:
            - from: '0'
            - to: '${listSize}'
            - increment_by: '1'
        publish:
          - index: '${return_result}'
        navigate:
          - HAS_MORE: getDeviceFromList
          - NO_MORE: startLab
          - FAILURE: on_failure
    - getListLength:
        do:
          io.cloudslang.base.lists.length:
            - list: '${deviceNames}'
            - delimiter: ','
        publish:
          - listSize: '${return_result}'
        navigate:
          - SUCCESS: adjustIndex
          - FAILURE: on_failure
    - createNode:
        do:
          Digital_twin.subflows.create_node_py:
            - labPath: '${labPath}'
            - deviceName: '${device}'
            - image: '${image}'
            - ipAddress: '${ipAddress}'
        navigate:
          - SUCCESS: add_device_to_NNM
    - startLab:
        do:
          Digital_twin.subflows.start_lab_py:
            - labPath: '${labPath}'
        navigate:
          - SUCCESS: SUCCESS
    - getDeviceFromList:
        do:
          io.cloudslang.base.lists.get_by_index:
            - list: '${deviceNames}'
            - delimiter: ','
            - index: '${index}'
        publish:
          - device: '${return_result}'
        navigate:
          - SUCCESS: getImageFromList
          - FAILURE: on_failure
    - getImageFromList:
        do:
          io.cloudslang.base.lists.get_by_index:
            - list: '${images}'
            - delimiter: ','
            - index: '${index}'
        publish:
          - image: '${return_result}'
        navigate:
          - SUCCESS: getIpAddressFromList
          - FAILURE: on_failure
    - getIpAddressFromList:
        do:
          io.cloudslang.base.lists.get_by_index:
            - list: '${ipAddresses}'
            - delimiter: ','
            - index: '${index}'
        publish:
          - ipAddress: '${return_result}'
        navigate:
          - SUCCESS: createNode
          - FAILURE: on_failure
    - adjustIndex:
        do:
          io.cloudslang.base.math.add_numbers:
            - value1: '${listSize}'
            - value2: '-1'
        publish:
          - listSize: '${result}'
        navigate:
          - SUCCESS: ForLoop
          - FAILURE: on_failure
    - add_device_to_NNM:
        do:
          Digital_twin.subflows.NNM_command:
            - cmd: "${'/opt/OV/bin/nnmloadseeds.ovpl -n '+ipAddress+' -t NAF_topology'}"
        navigate:
          - FAILURE: on_failure
          - SUCCESS: ForLoop
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      adjustIndex:
        x: 360
        'y': 80
      startLab:
        x: 680
        'y': 80
        navigate:
          72480cfe-bbbf-a7dc-fca9-b8c676542dc9:
            targetId: 921b774e-6d23-9421-9c5a-28358632e034
            port: SUCCESS
      getImageFromList:
        x: 360
        'y': 360
      ForLoop:
        x: 520
        'y': 80
      createLab:
        x: 40
        'y': 80
      getDeviceFromList:
        x: 200
        'y': 360
      add_device_to_NNM:
        x: 840
        'y': 360
      getListLength:
        x: 200
        'y': 80
      createNode:
        x: 680
        'y': 360
      getIpAddressFromList:
        x: 520
        'y': 360
    results:
      SUCCESS:
        921b774e-6d23-9421-9c5a-28358632e034:
          x: 1000
          'y': 80
