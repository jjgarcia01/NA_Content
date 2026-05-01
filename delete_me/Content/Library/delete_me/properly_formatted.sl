namespace: delete_me
flow:
  name: properly_formatted
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
          - SUCCESS:
              next_step: Step_4
              ROI: '15'
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
      Step_1:
        x: 40
        'y': 240
      Step_3:
        x: 360
        'y': 240
        navigate:
          7c0750af-d42e-1a9b-8e8c-8f1863ede1df:
            targetId: 768bd717-9cf4-0fd9-fc60-48ba64269439
            port: FAILURE
      Step_4:
        x: 560
        'y': 240
        navigate:
          0831d21b-905e-5be3-a8c7-8f4fd5fee0e6:
            targetId: aae1b070-63a7-aad1-f6e4-327be4350a0a
            port: FAILURE
      Step_2:
        x: 200
        'y': 240
      Step_5:
        x: 760
        'y': 240
        navigate:
          03d78097-63af-08cb-b11e-294f9842d89e:
            targetId: 8d302378-bfe9-ebc3-ffe1-826a8a9670f9
            port: SUCCESS
    results:
      FAILURE:
        aae1b070-63a7-aad1-f6e4-327be4350a0a:
          x: 560
          'y': 80
      SUCCESS:
        8d302378-bfe9-ebc3-ffe1-826a8a9670f9:
          x: 960
          'y': 240
      CUSTOM:
        768bd717-9cf4-0fd9-fc60-48ba64269439:
          x: 360
          'y': 440
