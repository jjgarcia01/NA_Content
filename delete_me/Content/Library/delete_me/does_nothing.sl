namespace: delete_me
operation:
  name: does_nothing
  python_action:
    use_jython: false
    script: "# do not remove the execute function\ndef execute():\n    \n    import requests\n    import json \n    import re \n    import datetime\n    from datetime import date   \n    \n    # code goes here\n# you can add additional helper methods below.\n    return_value = json.dumps({\n      \"command\": \"list device\",\n      \"parameters\": {\n       \"host\": \"the_dude\"\n      }\n    })\n    return {\"output\" : return_value}"
  outputs:
    - output: '${output}'
  results:
    - SUCCESS
