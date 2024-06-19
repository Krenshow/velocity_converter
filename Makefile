# ------------------------------------------------------------------------------
#                                ALIASES
# ------------------------------------------------------------------------------

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))
ROOT_DIR := $(MKFILE_DIR)

DOCKER_COMPOSE_FILES := \
	-f $(ROOT_DIR)/docker-compose.yaml

# ------------------------------------------------------------------------------

IMAGES := velocity_converter

# ------------------------------------------------------------------------------
#                               PARAMETERS
# ------------------------------------------------------------------------------

INPUT_TOPIC ?= example_topic
WHEEL_DISTNCE ?= 1.5
MAX_WHEEL_SPEED ?= 1.5  # absolute value

PARAMETERS := \
	ROOT_DIR=$(ROOT_DIR) \
	INPUT_TOPIC=$(INPUT_TOPIC) \
	WHEEL_DISTNCE=$(WHEEL_DISTNCE) \
	MAX_WHEEL_SPEED=$(MAX_WHEEL_SPEED)

# ------------------------------------------------------------------------------
#                                COMMANDS
# ------------------------------------------------------------------------------

BUILD_COMMAND := docker compose $(DOCKER_COMPOSE_FILES) build
RUN_COMMAND := docker compose $(DOCKER_COMPOSE_FILES) up

# ------------------------------------------------------------------------------
#                             GENERAL INTERFACE
# ------------------------------------------------------------------------------

build:
	@echo "ROOT_DIR: $(ROOT_DIR)"
	@echo "Building: $(IMAGES)"
	cd $(ROOT_DIR) && $(PARAMETERS) $(BUILD_COMMAND) $(IMAGES)

run: 
	@echo "Running: $(IMAGES)"
	cd $(ROOT_DIR) && $(PARAMETERS) $(RUN_COMMAND) $(IMAGES)
