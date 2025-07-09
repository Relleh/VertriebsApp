"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.pool = exports.query = void 0;
// Re-export from the new database adapter
var database_adapter_1 = require("./database-adapter");
Object.defineProperty(exports, "query", { enumerable: true, get: function () { return database_adapter_1.query; } });
Object.defineProperty(exports, "pool", { enumerable: true, get: function () { return database_adapter_1.pool; } });
