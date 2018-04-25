# See README.md
define goaudit::rule (
  Variant[String,Array[String]] $content,
  String $order = '10',
  Optional[String] $comment = undef,
) {

  datacat_fragment { "go-audit rule ${title}":
    target => $::goaudit::config_file,
    order  => $order,
    data   => {
      'rules' => [
        {
          'comment' => $comment,
          'content' => $content,
        },
      ],
    },
  }

}

