# See README.md
define goaudit::filter (
  Integer $syscall,
  Integer $message_type,
  String $regex,
  String $order = '10',
  Optional[String] $comment = undef,
) {
  datacat_fragment { "go-audit filter ${title}":
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

