namespace: stuff
flow:
  name: deployChangePlan_multipleServers
  inputs:
    - myList: 'tom,dick,harry'
  workflow:
    - list_iterator:
        do:
          io.cloudslang.base.lists.list_iterator:
            - list: '${myList}'
        publish:
          - name: '${result_string}'
        navigate:
          - HAS_MORE: string_equals
          - NO_MORE: not_found
          - FAILURE: on_failure
    - string_equals:
        do:
          io.cloudslang.base.strings.string_equals:
            - first_string: '${name}'
            - second_string: dorris
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: list_iterator
  results:
    - FAILURE
    - SUCCESS
    - not_found
extensions:
  graph:
    steps:
      list_iterator:
        x: 240
        'y': 160
        navigate:
          f127a013-0d17-ffdf-9658-1345795f2030:
            targetId: 21db4941-973f-b491-c654-c977e7314788
            port: NO_MORE
      string_equals:
        x: 480
        'y': 280
        navigate:
          05f96ddd-71d4-bc0a-c09f-6d760091627f:
            targetId: 8339ac5d-24aa-77ee-e64c-8f8cca370b26
            port: SUCCESS
    results:
      SUCCESS:
        8339ac5d-24aa-77ee-e64c-8f8cca370b26:
          x: 680
          'y': 280
      not_found:
        21db4941-973f-b491-c654-c977e7314788:
          x: 720
          'y': 160
