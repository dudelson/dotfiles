// you can have more than one listen command here

vimfx.listen('getCursorPosForCw', (data, callback) => {
    // returns the position of the cursor within text field tf
    // from https://stackoverflow.com/questions/2897155/get-cursor-position-in-characters-within-a-text-input-field#2897229 */
    var pos = -100;
    var tf = content.document.activeElement;
    if(typeof tf.selectionStart === 'number') {
        pos = tf.selectionDirection == 'backward' ? tf.selectionStart : tf.selectionEnd;
    }
    callback(pos);
});
