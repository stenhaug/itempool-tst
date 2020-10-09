t_multichoice <- '{
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
          "type": "multiple-choice",
          "id": "QxyRVz",
          "weight": 1,
          "stimulus": {
            "options": [
              {
                "id": "a",
                "doc": "[{\\"type\\":\\"paragraph\\",\\"children\\":[ANSWER1]}]"
              },
              {
                "id": "b",
                "doc": "[{\\"type\\":\\"paragraph\\",\\"children\\":[ANSWER2]}]"
              },
              {
                "id": "c",
                "doc": "[{\\"type\\":\\"paragraph\\",\\"children\\":[ANSWER3]}]"
              },
              {
                "id": "d",
                "doc": "[{\\"type\\":\\"paragraph\\",\\"children\\":[ANSWER4]}]"
              }
            ]
          },
          "rubric": {
            "correctOptionIds": [
              "THECORRECT"
            ]
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

t_multichoice_exp <- '{
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
          "type": "multiple-choice",
          "id": "QxyRVz",
          "weight": 1,
          "stimulus": {
            "options": [
              {
                "id": "a",
                "doc": "[{\\"type\\":\\"paragraph\\",\\"children\\":[ANSWER1]}]"
              },
              {
                "id": "b",
                "doc": "[{\\"type\\":\\"paragraph\\",\\"children\\":[ANSWER2]}]"
              },
              {
                "id": "c",
                "doc": "[{\\"type\\":\\"paragraph\\",\\"children\\":[ANSWER3]}]"
              },
              {
                "id": "d",
                "doc": "[{\\"type\\":\\"paragraph\\",\\"children\\":[ANSWER4]}]"
              }
            ]
          },
          "rubric": {
            "correctOptionIds": [
              "THECORRECT"
            ]
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