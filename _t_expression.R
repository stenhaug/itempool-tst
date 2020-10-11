t_expression <- '{
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
          "type": "expression",
          "id": "5afajQ",
          "weight": 1,
          "stimulus": {},
          "rubric": {
            "matchers": [
              {
                "id": "matcher-1",
                "latex": "(x+2)(x+3)",
                "normalizedScore": 1,
                "sameForm": true,
                "simplified": false
              }
            ],
            "defaultMatcher": {
              "normalizedScore": 0
            }
          },
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

t_expression_exp <- '{
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
          "type": "expression",
          "id": "5afajQ",
          "weight": 1,
          "stimulus": {},
          "rubric": {
            "matchers": [
              {
                "id": "matcher-1",
                "latex": "(x+2)(x+3)",
                "normalizedScore": 1,
                "sameForm": true,
                "simplified": false
              }
            ],
            "defaultMatcher": {
              "normalizedScore": 0
            }
          },
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
