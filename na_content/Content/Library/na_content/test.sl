namespace: na_content
flow:
  name: test
  workflow:
    - Sleep:
        do_external:
          d1bbf441-824a-450e-afae-2ddec0e0f35e:
            - seconds: '0'
        navigate:
          - success: SUCCESS
          - failure: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      Sleep:
        x: 240
        'y': 160
        navigate:
          394aa562-bd72-6b02-ff7e-9bca17fa20bb:
            targetId: c9bbe4da-1c89-2386-3059-f2781a4c8bdf
            port: success
    results:
      SUCCESS:
        c9bbe4da-1c89-2386-3059-f2781a4c8bdf:
          x: 520
          'y': 160
