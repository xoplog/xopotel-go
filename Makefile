
ME = xopotel-go

include ../xop-go/Makefile.peer

../xop-go/Makefile.peer:
	@echo "on branch $$GITHUB_REF_NAME" 
	cd .. ; git clone https://github.com/xoplog/xop-go --depth 1 -b "$$GITHUB_REF_NAME" || git clone https://github.com/xoplog/xop-go --depth 1
