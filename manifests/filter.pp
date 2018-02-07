# See README.md
define goaudit::filter (
  $syscall,
  $message_type,
  $regex,
  $order   = '10',
  $comment = undef,
) {

  validate_integer($order)
  if defined($comment) {
    validate_string($comment)
  }

  validate_integer($syscall)
  validate_integer($message_type)
  validate_string($regex)

  datacat_fragment { "go-audit filter ${title}" :
    target => $::goaudit::config_file,
    order  => $order,
    data   => {
      'filters' => [
        {
          'comment'      => $comment,
          'syscall'      => $syscall,
          'message_type' => $message_type,
          'regex'        => $regex,
        },
      ],
    },
  }
}

