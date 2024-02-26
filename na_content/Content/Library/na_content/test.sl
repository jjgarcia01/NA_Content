namespace: na_content
flow:
  name: test
  workflow:
    - generic_na_operation:
        do:
          na_content.generic_na_operation: []
        publish: []
        navigate:
          - SUCCESS: SUCCESS
  results:
    - SUCCESS
extensions:
  graph:
    steps:
      generic_na_operation:
        x: 240
        'y': 160
        navigate:
          c7b08d78-a409-fd97-3d03-e9815724a3e0:
            targetId: c9bbe4da-1c89-2386-3059-f2781a4c8bdf
            port: SUCCESS
    results:
      SUCCESS:
        c9bbe4da-1c89-2386-3059-f2781a4c8bdf:
          x: 520
          'y': 160
