# -*- coding: utf-8 -*- #
# frozen_string_literal: true

# this is based on the official Dracula theme color palette
# https://draculatheme.com/contribute

module Rouge
  module Themes
    class DraculaSlate < CSSTheme
      name 'dracula.slate'

      palette :background     => '#282a36'
      palette :current_line   => '#44475a'
      palette :foreground     => '#f8f8f2'
      palette :comment        => '#6272a4'
      palette :cyan           => '#8be9fd'
      palette :green          => '#50fa7b'
      palette :orange         => '#ffb86c'
      palette :pink           => '#ff79c6'
      palette :purple         => '#bd93f9'
      palette :red            => '#ff5555'
      palette :yellow         => '#f1fa8c'
      palette :selection      => '#44475a'
      palette :white          => '#ffffff'
      palette :black          => '#000000'

      style Generic::Heading,                 :fg => :comment
      style Literal::String::Regex,           :fg => :orange
      style Generic::Output,                  :fg => :comment
      style Generic::Prompt,                  :fg => :current_line
      style Generic::Strong,                  :bold => false
      style Generic::Subheading,              :fg => :foreground
      style Name::Builtin,                    :fg => :orange
      style Comment::Multiline,
            Comment::Preproc,
            Comment::Single,
            Comment::Special,
            Comment,                          :fg => :comment
      style Error,
            Generic::Error,
            Generic::Traceback,               :fg => :red
      style Generic::Deleted,
            Generic::Inserted,
            Generic::Emph,                    :fg => :current_line
      style Keyword::Constant,
            Keyword::Declaration,
            Keyword::Reserved,
            Name::Constant,
            Keyword::Type,                    :fg => :cyan
      style Literal::Number::Float,
            Literal::Number::Hex,
            Literal::Number::Integer::Long,
            Literal::Number::Integer,
            Literal::Number::Oct,
            Literal::Number,
            Literal::String::Char,
            Literal::String::Escape,
            Literal::String::Symbol,          :fg => :purple
      style Literal::String::Doc,
            Literal::String::Double,
            Literal::String::Backtick,
            Literal::String::Heredoc,
            Literal::String::Interpol,
            Literal::String::Other,
            Literal::String::Single,
            Literal::String,                  :fg => :yellow
      style Name::Attribute,
            Name::Class,
            Name::Decorator,
            Name::Exception,
            Name::Function,                   :fg => :green
      style Name::Variable::Class,
            Name::Namespace,
            Name::Entity,
            Name::Builtin::Pseudo,
            Name::Variable::Global,
            Name::Variable::Instance,
            Name::Variable,
            Text::Whitespace,
            Text,
            Name,                             :fg => :foreground
      style Name::Label,                      :fg => :pink
      style Operator::Word,
            Name::Tag,
            Keyword,
            Keyword::Namespace,
            Keyword::Pseudo,
            Operator,                         :fg => :pink
    end
  end
end
