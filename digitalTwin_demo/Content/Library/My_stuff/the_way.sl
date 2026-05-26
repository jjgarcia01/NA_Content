########################################################################################################################
#!!
#! @description: A lab record has the following format:
#!               devicename,deviceImage,ipAddress
#!!#
########################################################################################################################
namespace: My_stuff
flow:
  name: the_way
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
    - start_lab:
        do:
          Integrations.EveNG.Operations.start_lab:
            - labPath: '${labPath}'
        navigate:
          - SUCCESS: SUCCESS
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
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      create_lab:
        x: 200
        'y': 160
      start_lab:
        x: 680
        'y': 160
        navigate:
          70e41fcc-3fcc-04c4-5991-0c4d5996e526:
            targetId: 57db5c47-732f-a50e-991e-64e219051c35
            port: SUCCESS
      create_node:
        x: 360
        'y': 160
      add_to_nnmi:
        x: 520
        'y': 160
    results:
      SUCCESS:
        57db5c47-732f-a50e-991e-64e219051c35:
          x: 840
          'y': 160
