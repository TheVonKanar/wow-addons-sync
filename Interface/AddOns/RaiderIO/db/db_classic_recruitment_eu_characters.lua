--
-- Copyright (c) 2025 by RaiderIO, Inc.
-- All rights reserved.
--
local provider={name=...,data=3,region="eu",date="2026-05-23T08:06:33Z",numCharacters=3,db={}}
local F

F = function() provider.db["Garalon"]={0,"Gizoohunt"} end F()

F = nil
RaiderIO.AddProvider(provider)
