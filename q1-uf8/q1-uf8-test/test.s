# in Venus or Ripes, use the following code to use the ecall

# .data
# msg: .string "Hello, Venus!\n"
# .text
# main:
#     la a1, msg      # load address
#     li a0, 4        # syscall print_string
#     ecall

#     li a0, 10       # syscall exit
#     ecall


# .data
# msg: .string "Hello, Ripes!\n"
# main:
#     la a0, msg      # load address
#     li a7, 4        # syscall print_string
#     ecall

#     li a7, 10       # syscall exit
#     ecall