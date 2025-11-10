namespace: Customer.reporting
flow:
  name: convert_jsob_to_csv
  inputs:
    - stockList:
        prompt:
          type: text
    - stockInfo_Array: '[]'
  workflow:
    - list_iterator:
        do:
          io.cloudslang.base.lists.list_iterator:
            - list: '${stockList}'
        publish:
          - stockTicker: '${result_string}'
        navigate:
          - HAS_MORE: getStockInfo
          - NO_MORE: SUCCESS
          - FAILURE: on_failure
    - getStockInfo:
        do:
          Customer.reporting.getStockInfo:
            - stockTicker: '${stockTicker}'
        publish:
          - stockInfoJson
        navigate:
          - FAILURE: on_failure
          - SUCCESS: add_object_into_json_array
    - add_object_into_json_array:
        do:
          io.cloudslang.base.json.add_object_into_json_array:
            - json_array: '${stockInfo_Array}'
            - json_object: '${stockInfoJson}'
            - index: '0'
        publish:
          - stockInfoJson: '${return_result}'
        navigate:
          - SUCCESS: list_iterator
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      list_iterator:
        x: 120
        'y': 80
        navigate:
          83371562-8dc7-73bb-22fc-fd689f283cf5:
            targetId: 5493f629-99d7-1043-2819-e348d7d8af40
            port: NO_MORE
      getStockInfo:
        x: 120
        'y': 240
      add_object_into_json_array:
        x: 320
        'y': 240
    results:
      SUCCESS:
        5493f629-99d7-1043-2819-e348d7d8af40:
          x: 640
          'y': 80
