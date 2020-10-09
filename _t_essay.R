t_essay <- '{
  "title": "THETITLE",
  "tags": [THETAGS],
  "itemDoc": [
    {
      "type": "paragraph",
      "children": [
        THEQUESTION
      ]
    },
    {
      "type": "paragraph",
      "children": [
        {
          "text": ""
        },
        {
          "type": "free-response",
          "id": "PlAtY",
          "weight": 1,
          "stimulus": {},
          "rubric": {},
          "children": [
            {
              "text": ""
            }
          ]
        },
        {
          "text": ""
        }
      ]
    }
  ]
}'

t_essay_exp <- '{
  "title": "THETITLE",
  "tags": [THETAGS],
  "itemDoc": [
    {
      "type": "paragraph",
      "children": [
        THEQUESTION
      ]
    },
    {
      "type": "paragraph",
      "children": [
        {
          "text": ""
        },
        {
          "type": "free-response",
          "id": "PlAtY",
          "weight": 1,
          "stimulus": {},
          "rubric": {},
          "children": [
            {
              "text": ""
            }
          ]
        },
        {
          "text": ""
        }
      ]
    }
  ],
  "explanationDoc": [
    {
      "type": "paragraph",
      "children": [
        THEEXPLANATION
      ]
    }
  ]
}'
