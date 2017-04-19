define goaudit::rule (
  $order   = 10,
  $comment = undef,
  $content = '',
) {

  validate_integer($order)
  if defined($comment) {
    validate_string($comment)
  }

  datacat_fragment {"go-audit rule ${title}" :
    target       => $::goaudit::config_file,
    order        => $order,
    data         => {
      'rules'    => [
        {
          "comment" => $comment,
          "content" => $content,
        }
      ]
    }
  }

}

