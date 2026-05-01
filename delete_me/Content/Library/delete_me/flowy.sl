namespace: delete_me
flow:
  name: flowy
  workflow:
    - does_nothing:
        do:
          delete_me.does_nothing: []
        navigate:
          - SUCCESS: SUCCESS
  results:
    - SUCCESS
extensions:
  graph:
    steps:
      does_nothing:
        x: 40
        'y': 200
        navigate:
          242c002e-8746-020d-8b89-f384988f2195:
            targetId: 15434edb-2edb-fa26-fba8-3474d70d098a
            port: SUCCESS
    results:
      SUCCESS:
        15434edb-2edb-fa26-fba8-3474d70d098a:
          x: 640
          'y': 200
