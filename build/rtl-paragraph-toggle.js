( function( wp ) {
  const { addFilter } = wp.hooks;
  const { createHigherOrderComponent } = wp.compose;
  const { InspectorControls, BlockListBlock } = wp.blockEditor || wp.editor;
  const { PanelBody, ToggleControl } = wp.components;
  const el = wp.element.createElement;

  // 1) Add "dir" attribute to core/paragraph
  addFilter(
    'blocks.registerBlockType',
    'rpt/paragraph-dir-attr',
    function( settings, name ) {
      if ( name !== 'core/paragraph' ) return settings;
      settings.attributes = Object.assign({}, settings.attributes, {
        dir: {
          type: 'string', // 'rtl' or 'ltr'
          enum: [ 'rtl', 'ltr' ],
          default: undefined
        }
      });
      return settings;
    }
  );

  // 2) Add toggle in Inspector for Paragraph
  const withRTLToggle = createHigherOrderComponent( ( BlockEdit ) => {
    return ( props ) => {
      if ( props.name !== 'core/paragraph' ) return el( BlockEdit, props );

      const isRTL = props.attributes.dir === 'rtl';

      return el(
        wp.element.Fragment,
        {},
        el( BlockEdit, props ),
        el(
          InspectorControls,
          {},
          el(
            PanelBody,
            { title: 'Text Direction', initialOpen: true },
            el( ToggleControl, {
              label: 'Set paragraph as RTL',
              checked: isRTL,
              onChange: (val) =>
                props.setAttributes({ dir: val ? 'rtl' : undefined })
            })
          )
        )
      );
    };
  }, 'withRTLToggle' );

  addFilter( 'editor.BlockEdit', 'rpt/with-rtl-toggle', withRTLToggle );

  // 3) Apply dir attribute on save
  addFilter(
    'blocks.getSaveContent.extraProps',
    'rpt/add-dir-to-save',
    function( extraProps, blockType, attributes ) {
      if ( blockType.name !== 'core/paragraph' ) return extraProps;
      if ( attributes.dir ) extraProps.dir = attributes.dir;
      return extraProps;
    }
  );

  // 4) Reflect dir in editor canvas (wrapper) for live preview
  const withDirOnEditor = createHigherOrderComponent( ( OriginalBlockListBlock ) => {
    return ( props ) => {
      if ( props.name !== 'core/paragraph' ) {
        return el( OriginalBlockListBlock, props );
      }
      const dir = props.attributes.dir;
      const wrapperProps = Object.assign({}, props.wrapperProps || {});
      if ( dir ) wrapperProps.dir = dir;
      return el( OriginalBlockListBlock, Object.assign({}, props, { wrapperProps }) );
    };
  }, 'withDirOnEditor' );

  addFilter( 'editor.BlockListBlock', 'rpt/dir-on-editor', withDirOnEditor );

} )( window.wp );
