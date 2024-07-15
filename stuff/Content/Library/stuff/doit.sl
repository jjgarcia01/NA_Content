namespace: stuff
flow:
  name: doit
  workflow:
    - Sleep:
        do_external:
          d1bbf441-824a-450e-afae-2ddec0e0f35e:
            - seconds: '0'
        navigate:
          - success: SUCCESS
          - failure: FAILURE_1
  results:
    - FAILURE_1
    - SUCCESS
extensions:
  graph:
    steps:
      Sleep:
        x: 240
        'y': 120
        navigate:
          f82bc99b-1093-285d-53ee-21447f13505f:
            targetId: 6b5bfe59-f286-042b-6e6e-f2a76561477f
            port: failure
          5081e5aa-b357-8f4b-fe2c-8a70c55d1b7d:
            targetId: 65143213-18e2-fb0a-d876-39c9e319855e
            port: success
    results:
      FAILURE_1:
        6b5bfe59-f286-042b-6e6e-f2a76561477f:
          x: 320
          'y': 280
      SUCCESS:
        65143213-18e2-fb0a-d876-39c9e319855e:
          x: 440
          'y': 120
