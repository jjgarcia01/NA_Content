namespace: delete_me
flow:
  name: how_not_to_create_a_flow
  workflow:
    - Step_1:
        do:
          io.cloudslang.base.utils.do_nothing: []
        navigate:
          - SUCCESS: Step_2
          - FAILURE: on_failure
    - Step_3:
        do:
          io.cloudslang.base.utils.do_nothing: []
        navigate:
          - SUCCESS: Step_4
          - FAILURE: CUSTOM
    - Step_4:
        do:
          io.cloudslang.base.utils.do_nothing: []
        navigate:
          - SUCCESS: Step_5
          - FAILURE: FAILURE
    - Step_2:
        do:
          io.cloudslang.base.utils.do_nothing: []
        navigate:
          - SUCCESS: Step_3
          - FAILURE: on_failure
    - Step_5:
        do:
          io.cloudslang.base.utils.do_nothing: []
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
    - CUSTOM
extensions:
  graph:
    steps:
      Step_4:
        x: 400
        'y': 40
        navigate:
          0831d21b-905e-5be3-a8c7-8f4fd5fee0e6:
            targetId: aae1b070-63a7-aad1-f6e4-327be4350a0a
            port: FAILURE
      Step_2:
        x: 200
        'y': 360
      Step_3:
        x: 600
        'y': 200
        navigate:
          50577111-33de-4887-b6b8-99f65ece7fc8:
            targetId: 768bd717-9cf4-0fd9-fc60-48ba64269439
            port: FAILURE
      Step_1:
        x: 320
        'y': 160
      Step_5:
        x: 640
        'y': 400
        navigate:
          03d78097-63af-08cb-b11e-294f9842d89e:
            targetId: 8d302378-bfe9-ebc3-ffe1-826a8a9670f9
            port: SUCCESS
    results:
      SUCCESS:
        8d302378-bfe9-ebc3-ffe1-826a8a9670f9:
          x: 800
          'y': 240
      FAILURE:
        aae1b070-63a7-aad1-f6e4-327be4350a0a:
          x: 480
          'y': 440
      CUSTOM:
        768bd717-9cf4-0fd9-fc60-48ba64269439:
          x: 680
          'y': 40
