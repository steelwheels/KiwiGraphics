#
# unittest.mk
#

TEST_NAME	= UnitTest

unit_test	= $(BUILD_DIR)/$(CONFIGURATION)/$(TEST_NAME)
test_dir	= ../UnitTest/$(TEST_NAME)
test_log	= $(BUILD_DIR)/$(CONFIGURATION)/$(TEST_NAME).log

unit_test: dummy
	test -x $(unit_test)
	(cd $(test_dir) ; \
	 $(unit_test) 2>&1 | grep -v "Which one is undefined" > $(test_log) \
	)
	diff $(test_log) $(test_dir)/$(TEST_NAME).log.OK

dummy:

