# Table of stories.
# Arguments:
# * Stories: Backbone Collection.

DocumentHelper         = require("document-helper")
React                  = require("react")
R                      = require("react-dom")

HumanTime              = require("components/shared/human-time")
Modal                  = require("components/shared/modal")

StoryList = React.createClass
  displayName: "storyList"

  render: ->
    R.table {className: "table stories"},
      R.thead null,
        R.th {className: "id"}, "ID"
        R.th {className: "title"}, "Title"
        R.th {className: "description"}, "Description"
        R.th {className: "created-at"}, "Created At"
        R.th {className: "delete-story"}, "Delete"
      R.tbody null, @props.collection.map(@rowRender)

  rowRender: (story) ->
    R.tr {"data-id": story.id, key: story.id},
      R.td {className: "id"}, story.id
      R.td {className: "title"},
        R.a {className: "link", href: "/stories/#{story.id}", onClick: @navigateStory.bind(this, "/stories/#{story.id}")}, story.title
        R.a {className: "link", href: "/stories/#{story.id}/edit", onClick: @navigateStory.bind(this, "/stories/#{story.id}/edit")}, "(edit)"
      R.td {className: "description"}, story.description
      R.td {className: "created-at"},
        HumanTime(datetime: story.created_at)
      R.td {className: "link delete-story", onClick: @confirmDeleteRender.bind(this, story)}, "Delete"

  confirmDeleteRender: (story) ->
    confirmationModal = Modal
      title: "Confirm Deletion"
      type: "warning"

      body: [
        R.p {key: "text"}, "Are you sure you want to delete"
        R.p {key: "title"}, '"' + story.title + '"?'
      ]

      actions: [
        R.span {
          className: "btn dark btn-danger"
          key: "delete"
          onClick: @delete.bind(this, story.id)
          "data-dismiss": "modal"
        }, "Yes"

        R.span {
          className: "btn dark btn-primary"
          key: "cancel"
          "data-dismiss": "modal"
        }, "No"
      ]

    DocumentHelper.render
      anchor: "aboveContent"
      component: confirmationModal

  navigateStory: (href, e) ->
    e.preventDefault()
    DocumentHelper.navigate href, true

  delete: (id) ->
    model = @getCollection().get(id)

    model.destroy
      success: =>
        @forceUpdate()

module.exports = StoryList
