define goaudit::filter (
  $order   = 10,
  $comment = undef,
  $syscall,
  $message_type,
  $regex
) {

  validate_integer($order)
  if defined($comment) {
    validate_string($comment)
  }

  validate_integer($syscall)
  validate_integer($message_type)
  validate_string($regex)

  datacat_fragment { "go-audit filter ${title}" :
    target      => $::goaudit::config_file,
    order       => $order,
    data        => {
      'filters' => [
        {
          "comment"      => $comment,
          "syscall"      => $syscall,
          "message_type" => $message_type,
          "regex"        => $regex,
        },
      ],
    },
  }
}

