t_solve <- '{
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
          "type": "math",
          "latex": "THELEFT=",
          "children": [
            {
              "text": ""
            }
          ]
        },
        {
          "text": " "
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
                "latex": "THERIGHT",
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

t_solve_exp <- '{
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
          "type": "math",
          "latex": "THELEFT = ",
          "children": [
            {
              "text": ""
            }
          ]
        },
        {
          "text": " "
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
                "latex": "THERIGHT",
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
