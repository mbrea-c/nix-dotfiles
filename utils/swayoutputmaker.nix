{ primary, secondary, primaryScale, secondaryScale }: {

  outputs = [
    {
      name = primary;
      scale = primaryScale;
    }
    {
      name = secondary;
      scale = secondaryScale;
    }
  ];
  workspaces = [
    {
      name = "1";
      outputList = [ primary ];
    }
    {
      name = "2";
      outputList = [ primary ];
    }
    {
      name = "3";
      outputList = [ primary ];
    }
    {
      name = "4";
      outputList = [ secondary primary ];
    }
    {
      name = "5";
      outputList = [ secondary primary ];
    }
    {
      name = "6";
      outputList = [ secondary primary ];
    }
    {
      name = "7";
      outputList = [ secondary primary ];
    }
    {
      name = "8";
      outputList = [ secondary primary ];
    }
    {
      name = "9";
      outputList = [ secondary primary ];
    }
    {
      name = "10";
      outputList = [ secondary primary ];
    }
  ];
}
