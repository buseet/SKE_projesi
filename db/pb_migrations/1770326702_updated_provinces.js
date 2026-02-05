/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_3904711375")

  // remove field
  collection.fields.removeById("date2218467061")

  // add field
  collection.fields.addAt(9, new Field({
    "hidden": false,
    "id": "number2218467061",
    "max": 10000,
    "min": 1500,
    "name": "start_year",
    "onlyInt": false,
    "presentable": false,
    "required": false,
    "system": false,
    "type": "number"
  }))

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_3904711375")

  // add field
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

  // remove field
  collection.fields.removeById("number2218467061")

  return app.save(collection)
})
