# See README.md
define goaudit::rule (
  $order   = 10,
  $comment = undef,
  $content,
) {

  validate_integer($order)
  if ($comment != undef) {
    validate_string($comment)
  }
  if ! (is_array($content) or is_string($content)) {
    fail('content must be a string or an array of strings')
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

