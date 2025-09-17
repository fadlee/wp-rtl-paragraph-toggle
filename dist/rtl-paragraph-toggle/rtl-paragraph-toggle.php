<?php
/**
 * Plugin Name: RTL Paragraph Toggle
 * Description: Add a toggle in Paragraph block to set dir="rtl" and auto-apply custom RTL typography. Works with any WordPress theme.
 * Version: 1.0.0
 * Author: You
 * License: GPL-2.0+
 */

if ( ! defined( 'ABSPATH' ) ) exit;

define( 'RPT_PLUGIN_URL', plugin_dir_url( __FILE__ ) );
define( 'RPT_PLUGIN_PATH', plugin_dir_path( __FILE__ ) );

add_action( 'init', function () {
  // Editor script
  wp_register_script(
    'rpt-editor-js',
    RPT_PLUGIN_URL . 'build/rtl-paragraph-toggle.js',
    array( 'wp-i18n', 'wp-hooks', 'wp-compose', 'wp-components', 'wp-element', 'wp-blocks', 'wp-block-editor', 'wp-editor' ),
    '1.0.0',
    true
  );

  // Editor styles (also load Amiri)
  wp_register_style(
    'rpt-editor-css',
    RPT_PLUGIN_URL . 'css/editor.css',
    array(),
    '1.0.0'
  );

  // Frontend styles (also load Amiri)
  wp_register_style(
    'rpt-frontend-css',
    RPT_PLUGIN_URL . 'css/frontend.css',
    array(),
    '1.0.0'
  );

  // Enqueue in editor
  add_action( 'enqueue_block_editor_assets', function () {
    wp_enqueue_script( 'rpt-editor-js' );
    wp_enqueue_style( 'rpt-editor-css' );
  });

  // Enqueue in frontend
  add_action( 'wp_enqueue_scripts', function () {
    wp_enqueue_style( 'rpt-frontend-css' );
  });
});
