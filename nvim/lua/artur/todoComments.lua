local status_ok, comment = pcall(require, "todo-comments")
if not status_ok then
  return
end

comment.setup()
