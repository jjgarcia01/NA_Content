namespace: delete_me
flow:
  name: test_output
  workflow:
    - does_nothing:
        do:
          delete_me.does_nothing: []
        publish:
          - output
        navigate:
          - SUCCESS: SUCCESS
  outputs:
    - flow_output_0
  results:
    - SUCCESS
extensions:
  graph:
    steps:
      does_nothing:
        x: 280
        'y': 160
        navigate:
          0c0d5555-7d79-4cb5-a332-936c7f9f51e6:
            targetId: 3b4eb913-e427-6a13-b857-d4800d660cef
            port: SUCCESS
    results:
      SUCCESS:
        3b4eb913-e427-6a13-b857-d4800d660cef:
          x: 520
          'y': 160
