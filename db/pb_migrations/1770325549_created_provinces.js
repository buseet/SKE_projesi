/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = new Collection({
    "createRule": "",
    "deleteRule": "",
    "fields": [
      {
        "autogeneratePattern": "[a-z0-9]{15}",
        "hidden": false,
        "id": "text3208210256",
        "max": 15,
        "min": 15,
        "name": "id",
        "pattern": "^[a-z0-9]+$",
        "presentable": false,
        "primaryKey": true,
        "required": true,
        "system": true,
        "type": "text"
      },
      {
        "hidden": false,
        "id": "number2217801435",
        "max": 100,
        "min": 1,
        "name": "row",
        "onlyInt": true,
        "presentable": false,
        "required": true,
        "system": false,
        "type": "number"
      },
      {
        "autogeneratePattern": "",
        "hidden": false,
        "id": "text4262580536",
        "max": 0,
        "min": 0,
        "name": "Name",
        "pattern": "",
        "presentable": false,
        "primaryKey": false,
        "required": true,
        "system": false,
        "type": "text"
      },
      {
        "autogeneratePattern": "",
        "hidden": false,
        "id": "text1821122886",
        "max": 4,
        "min": 4,
        "name": "trid",
        "pattern": "",
        "presentable": false,
        "primaryKey": false,
        "required": true,
        "system": false,
        "type": "text"
      },
      {
        "hidden": false,
        "id": "select2811673258",
        "maxSelect": 1,
        "name": "ske_status",
        "presentable": false,
        "required": true,
        "system": false,
        "type": "select",
        "values": [
          "Aktif",
          "Planlıyor",
          "Yok",
          "Devam Ettirmiyor"
        ]
      },
      {
        "hidden": false,
        "id": "date2218467061",
        "max": "",
        "min": "",
        "name": "start_year",
        "presentable": false,
        "required": true,
        "system": false,
        "type": "date"
      },
      {
        "hidden": false,
        "id": "number3738350090",
        "max": 100,
        "min": 0,
        "name": "gender_equality",
        "onlyInt": false,
        "presentable": false,
        "required": true,
        "system": false,
        "type": "number"
      },
      {
        "hidden": false,
        "id": "select258142582",
        "maxSelect": 1,
        "name": "region",
        "presentable": false,
        "required": true,
        "system": false,
        "type": "select",
        "values": [
          "ANKARA",
          "BATI AKDENİZ",
          "BATI KARADENİZ",
          "DOĞU AKDENİZ",
          "DOĞU ANADOLU",
          "DOĞU KARADENİZ",
          "EGE BÖLGE",
          "GÜNEYDOĞU ANADOLU",
          "İÇ ANADOLU",
          "İSTANBUL",
          "İZMİR",
          "MARMARA",
          "TRAKYA"
        ]
      },
      {
        "hidden": false,
        "id": "select4240198992",
        "maxSelect": 1,
        "name": "high_schools",
        "presentable": false,
        "required": true,
        "system": false,
        "type": "select",
        "values": [
          "Aktif",
          "Yok",
          "Planlıyor",
          "Devam Ettirmiyor"
        ]
      },
      {
        "hidden": false,
        "id": "select3814745566",
        "maxSelect": 1,
        "name": "universities",
        "presentable": false,
        "required": true,
        "system": false,
        "type": "select",
        "values": [
          "Aktif",
          "Yok",
          "Planlıyor",
          "Devam Ettirmiyor"
        ]
      },
      {
        "hidden": false,
        "id": "autodate2990389176",
        "name": "created",
        "onCreate": true,
        "onUpdate": false,
        "presentable": false,
        "system": false,
        "type": "autodate"
      },
      {
        "hidden": false,
        "id": "autodate3332085495",
        "name": "updated",
        "onCreate": true,
        "onUpdate": true,
        "presentable": false,
        "system": false,
        "type": "autodate"
      }
    ],
    "id": "pbc_3904711375",
    "indexes": [],
    "listRule": "",
    "name": "provinces",
    "system": false,
    "type": "base",
    "updateRule": "",
    "viewRule": ""
  });

  return app.save(collection);
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_3904711375");

  return app.delete(collection);
})
