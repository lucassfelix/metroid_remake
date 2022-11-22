extends Node


const PLAYER_LAYER := 1
const ENEMY_LAYER := 2
const ENVIRONMENT_LAYER := 4
const BEAM_LAYER := 8
const CAMERA_LAYER := 16
const SPAWNER_LAYER := 32


const INITIAL_ENERGY := 30
const PLAYER_INVINCIBILITY_TIME := 2
const ENEMY_INVINCIBILITY_TIME := 0.2
const BEAM_LIFETIME := 0.2
const HOLD_DELAY := 0.8
const HITSTOP_TIME := 0.2
const DELAY_BETWEEN_SHOTS := 0.13