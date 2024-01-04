#!/bin/bash

# 1. 작성된 우분투 태그 나열
#(!)변수랑 = 사이에 공간이 있으면 안됨
list_tag=("16.04" "18.04" "20.04" "22.04" "23.04" "23.10" "24.04")

echo "[작성된 rd_pwn 태그들]"
for tag in "${list_tag[@]}"; do
	echo -n "$tag " # -n옵션 줄바꿈없이 출력
done

echo "" # 줄바꿈 용도
echo ""

# 2. 나열된 태그에서 입력값 받기
echo -n "가동할 태그를 입력하세요 >> "
read input_tag
# echo "선택한 버전은 $input_version 입니다."

# 3. 선택한 버전에 따라 다른 스크립 가동(switch)
# (+) 쉘스크립트로 명령어 수행
# => dockerfile로 이미지가 이미 만들어져 있다
case "$input_tag" in 
	"16.04")
		docker run -it --rm --cap-add SYS_PTRACE --security-opt seccomp:unconfined --name 16.04 -v ${PWD}/../data:/data rd_pwn:16.04 /usr/bin/zsh
		;;
	"18.04")
		docker run -it --rm --cap-add SYS_PTRACE --security-opt seccomp:unconfined --name 18.04 -v ${PWD}/../data:/data rd_pwn:18.04 /usr/bin/zsh
		;;
	"20.04")
		docker run -it --rm --cap-add SYS_PTRACE --security-opt seccomp:unconfined --name 20.04 -v ${PWD}/../data:/data rd_pwn:20.04 /usr/bin/zsh
		;;
	"22.04")
		docker run -it --rm --cap-add SYS_PTRACE --security-opt seccomp:unconfined --name 22.04 -v ${PWD}/../data:/data rd_pwn:22.04 /usr/bin/zsh
		;;
	"23.04")
		docker run -it --rm --cap-add SYS_PTRACE --security-opt seccomp:unconfined --name 23.04 -v ${PWD}/../data:/data rd_pwn:23.04 /usr/bin/zsh
		;;
	"23.10")
		docker run -it --rm --cap-add SYS_PTRACE --security-opt seccomp:unconfined --name 23.10 -v ${PWD}/../data:/data rd_pwn:23.10 /usr/bin/zsh
		;;
	"24.04")
		docker run -it --rm --cap-add SYS_PTRACE --security-opt seccomp:unconfined --name 24.04 -v ${PWD}/../data:/data rd_pwn:24.04 /usr/bin/zsh
		;;
esac
