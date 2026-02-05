/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_3904711375")

  // update field
  collection.fields.addAt(5, new Field({
    "hidden": false,
    "id": "date2218467061",
    "max": "",
    "min": "",
    "name": "start_year",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "date"
  }))

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_3904711375")

  // update field
  collection.fields.addAt(5, new Field({
    "hidden": false,
    "id": "date2218467061",
    "max": "",
    "min": "",
    "name": "start_year",
    "presentable": false,
    "required": true,
    "system": false,
    "type": "date"
  }))

  return app.save(collection)
})
