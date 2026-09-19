{
  runCommand,
  buildPackages,
  originalPatch,
}:
# Keep the AVF changes intact while rebasing their context onto newer Linux 6.1.
runCommand "arm64-balloon-rebased.patch" { } ''
  cp ${originalPatch} "$out"
  chmod u+w "$out"
  ${buildPackages.patch}/bin/patch --batch --fuzz=0 "$out" \
    ${./arm64-balloon-context.patch}
''
