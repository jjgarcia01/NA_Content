namespace: Digital_twin.actions
flow:
  name: run_me
  workflow:
    - Create_lab_NG:
        do:
          Digital_twin.actions.Create_lab_NG: []
        publish:
          - thing_one: thing_one
        navigate:
          - SUCCESS:
              next_step: SUCCESS
              ROI: '300'
          - FAILURE: on_failure
  outputs:
    - flow_output_0
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      Create_lab_NG:
        x: 360
        'y': 160
        navigate:
          bf75f014-0931-de6a-5c4d-265ab1db202d:
            targetId: a4de9975-3874-ddd1-dd69-d03ddb1ee65d
            port: SUCCESS
    results:
      SUCCESS:
        a4de9975-3874-ddd1-dd69-d03ddb1ee65d:
          x: 560
          'y': 160
